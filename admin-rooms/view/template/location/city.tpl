<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="col-md-6">
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<?php foreach($citys as $city){?>
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading_<?php echo $city['city_id']?>">
				      <h4 class="panel-title">
				        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#city_<?php echo $city['city_id']?>" aria-expanded="false" aria-controls="collapse_<?php echo $city['city_id']?>">
				         <?php echo $city['name']?>
				        </a>
				        <button style="float: right;" onclick="editCity(<?php echo $city['city_id']?>)">Edit</button>
				      </h4>
				    </div>
				    <div id="city_<?php echo $city['city_id']?>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading_<?php echo $city['city_id']?>">
				    <?php foreach($city['districts'] as $district ){?>
				      <div class="panel-body">
				      	<?php echo $district['name']?>
				      <button style="float: right;" onclick="editDistrict(<?php echo $district['district_id']?>)">Edit</button>

				      </div>
				      <?php } ?>
				    </div>
				    
				 </div>
			<?php } ?>
		</div>
	</div>
	<div class="col-md-6">
		<div class="row" id="wrap-city" style="display: none;">
			<form action="index.php?route=location/city/edit&token=<?php echo $token; ?>" method="POST">	
				<input type="hidden" name="city_id">
				<input type="hidden" name="city" value="1">
				<label>Tên</label>
				<input class="form-control" type="text" name="name">

				<label>Code</label>
				<input class="form-control" type="number" name="code">

				<label>Tọa độ</label>
				<textarea class="form-control" name="location"></textarea> 

				<label>Khu vực</label>
				<textarea class="form-control" name="area"></textarea> 

				<div id="searchresult">
					
				</div>
				
				<label>Mô tả</label>
				<textarea class="form-control" name="description"></textarea> 

				<label>Meta title</label>
				<textarea class="form-control" name="meta_title"></textarea> 

				<label>Meta description</label>
				<textarea class="form-control" name="meta_description"></textarea> 

				<label>Meta keyword</label>
				<textarea class="form-control" name="meta_keyword"></textarea> 
				<button type="submit">Edit</button>
				<button onclick="cancel('city')">Cancel</button>
			</form>
		</div>
		<div class="row" id="wrap-district" style="display: none">
			<form action="index.php?route=location/city/edit&token=<?php echo $token; ?>" method="POST">
				<input type="hidden" name="district_id">
				<input type="hidden" name="district" value="1">
				<label>Tên</label>
				<input class="form-control" type="text" name="name">

				<label>Code</label>
				<input class="form-control" type="number" name="code">

				<label>Tọa độ</label>
				<textarea class="form-control" name="location"></textarea> 
				
				<label>Khu vực</label>
				<textarea class="form-control" name="area"></textarea> 
				<div id="searchresult1">
					
				</div>
				<label>Mô tả</label>
				<textarea class="form-control" name="description"></textarea> 

				<label>Meta title</label>
				<textarea class="form-control" name="meta_title"></textarea> 

				<label>Meta description</label>
				<textarea class="form-control" name="meta_description"></textarea> 

				<label>Meta keyword</label>
				<textarea class="form-control" name="meta_keyword"></textarea> 
				<button type="submit">Edit</button>
				<button onclick="cancel('district')">Cancel</button>

			</form>
		</div>

	</div>
</div>
<script type="text/javascript">
	var	array = [];
	function cancel(name){
		if(name == 'city')
			$('#wrap-city').css('display','none');
		else
			$('#wrap-district').css('display','none');
	}
	function editCity(id){
		$('#wrap-city').css('display','block');
		$.ajax({
			url:'index.php?route=location/city/getCity&token=<?php echo $token; ?>',
			type:'POST',
			data:{id:id},
			dataType: 'json',
			success:function(data){
				$('input[name=city_id]').val(data[0].city_id);
				$('input[name=name]').val(data[0].name);
				$('input[name=code]').val(data[0].code);
				// $('textarea[name=area]').val(JSON.stringify(data[0]['polygon']['coordinates']));
				$('textarea[name=location]').val(data[0].location['coordinates']);
				$('textarea[name=description]').val(data[0].description);
				$('textarea[name=meta_title]').val(data[0].meta_title);
				$('textarea[name=meta_description]').val(data[0].meta_description);
				$('textarea[name=meta_keyword]').val(data[0].meta_keyword);
				$.ajax({
					url:"https://nominatim.openstreetmap.org/search?q="+data[0].name+"&format=json&polygon=1&country=Vietnam&country_code=vn&city=Ho%20Chi%20Minh%20City&polygon_geojson=1",
					success:function(data){
						$('#searchresult').empty();
						
						$.each(data , function(index, val) { 
						  $('#searchresult').append('<div class="result highlight" ><span class="name">'+val['display_name']+'</span> <span class="type">('+val['type']+')</span> <a onclick="getPolygon('+index+')" >details</a></div>')
						  array.push(val);
						});
					}
				})
			}
		})
	}
	function editDistrict(id){
		$('#wrap-district').css('display','block');
		$.ajax({
			url:'index.php?route=location/city/getdistrict&token=<?php echo $token; ?>',
			type:'POST',
			data:{id:id},
			dataType: 'json',
			success:function(data){
				$('input[name=district_id]').val(data[0].district_id);
				$('input[name=name]').val(data[0].name);
				$('input[name=code]').val(data[0].code);
				// $('textarea[name=area]').val(JSON.stringify(data[0]['polygon']['coordinates']));
				$('textarea[name=location]').val(data[0].location['coordinates']);
				$('textarea[name=description]').val(data[0].description);
				$('textarea[name=meta_title]').val(data[0].meta_title);
				$('textarea[name=meta_description]').val(data[0].meta_description);
				$('textarea[name=meta_keyword]').val(data[0].meta_keyword);
				$.ajax({
					url:"https://nominatim.openstreetmap.org/search?q="+data[0].name+"&format=json&polygon=1&country=Vietnam&country_code=vn&city=Ho%20Chi%20Minh%20City&polygon_geojson=1",
					success:function(data){
						$('#searchresult1').empty();

						$.each(data , function(index, val) { 
						  $('#searchresult1').append('<div class="result highlight" ><span class="name">'+val['display_name']+'</span> <span class="type">('+val['type']+')</span> <a onclick="getPolygon('+index+')" >details</a></div>')
						  array.push(val);
						});
					}
				})
			}
		})
	}
	function getPolygon(index){
		$('textarea[name=location]').val(array[index].lon+','+array[index].lat);
		console.log(array[index].polygonpoints);
		$('textarea[name=area]').val(JSON.stringify(array[index].polygonpoints));
	}

</script>