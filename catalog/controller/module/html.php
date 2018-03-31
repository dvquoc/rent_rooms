<?php
class ControllerModuleHTML extends Controller {
	public function index($setting) {
		if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['title'], ENT_QUOTES, 'UTF-8');
			$data['html'] = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8');

            preg_match_all("/\<code\>\[module code=\'(.*?)\'\](\d+)\[\/module\]\<\/code\>/", $data['html'],$modules,PREG_SET_ORDER);
            if(!empty($modules)) {
                foreach ($modules as $module) {
                    if (isset($module[1])) {
                        $this->load->model('extension/module');
                        $setting_info = $this->model_extension_module->getModule($module[2]);
                        $html_module = $this->load->controller('module/' . $module[1], $setting_info);
                        $data['html'] = str_replace("<code>[module code='" . $module[1] . "']" . $module[2] . "[/module]</code>", $html_module, $data['html']);
                    }
                }
            }

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/html.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/html.tpl', $data);
			} else {
				return $this->load->view('default/template/module/html.tpl', $data);
			}
		}
	}
}