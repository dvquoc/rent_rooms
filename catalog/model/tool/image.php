<?php
class ModelToolImage extends Model {
	public function resize($filename, $width=false, $height=false,$type='') {
		if (!is_file(DIR_IMAGE . $filename)) {
			return;
		}
        if(!$width || !$height){
            if ($this->request->server['HTTPS']) {
                return $this->config->get('config_ssl') . 'image/' . $filename;
            } else {
                return $this->config->get('config_url') . 'image/' . $filename;
            }
        }

		$extension = pathinfo($filename, PATHINFO_EXTENSION);
		$old_image = $filename;
		$new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . '.' . $extension;

		if (!is_file(DIR_IMAGE . $new_image) || (filectime(DIR_IMAGE . $old_image) > filectime(DIR_IMAGE . $new_image))) {
			$path = '';

			$directories = explode('/', dirname(str_replace('../', '', $new_image)));

			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;
				
				if (!is_dir(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}
			}

			list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);
			if ($width_orig != $width || $height_orig != $height) {
				$image = new Image(DIR_IMAGE . $old_image);
                if ($type == 'a') {
                    if ($width/$height > $width_orig/$height_orig) {
                        $image->resize($width, $height, 'w');
                    } elseif ($width/$height < $width_orig/$height_orig) {
                        $image->resize($width, $height, 'h');
                    }
                } else {
                    $image->resize($width, $height, $type);
                }
				$image->save(DIR_IMAGE . $new_image);
			} else {
				copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
			}
		}

		if ($this->request->server['HTTPS']) {
			return $this->config->get('config_ssl') . 'image/' . $new_image;
		} else {
			return $this->config->get('config_url') . 'image/' . $new_image;
		}
	}
}