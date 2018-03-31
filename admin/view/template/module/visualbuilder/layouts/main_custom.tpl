<?php if($show_position) { ?> 
<div class="header">
    <div class="row">
        <div class="col-md-6">
            <?php include ($adminPositionsDir . "top_left.tpl");	?>
        </div>
        <div class="col-md-6">
            <?php include ($adminPositionsDir . "top_right.tpl");	?>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "header_left.tpl");	?>
        </div>
        <div class="col-md-4">
           <?php include ($adminPositionsDir . "header_center.tpl");	?>
        </div>
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "header_right.tpl");	?> 
        </div>
    </div>
</div>
<div class="menu">
    <div class="menu row">
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "menu_left.tpl");	?>
        </div>
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "menu_main.tpl");	?>
        </div>
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "menu_right.tpl");	?>
        </div>
    </div>
</div>
<div class="slider row">
    <div class="col-md-12">
        <?php include ($adminPositionsDir . "content_slider.tpl");	?>
    </div>
</div> 
<div class="content_custom_top row">
    <div class="col-md-12">
        <?php include ($adminPositionsDir . "custom_top.tpl");	?>
    </div>
</div>
<?php } else{ ?>
	<div class="alert alert-success" role="alert">Hãy chuyển đổi themes hiện tại thành themes Mb_themes, Nếu không hãy config themes để kế thừa nhiều vị trí hiển thị module hơn</div>
<?php } ?>
<div class="content">
    <div class="row builder-grid">
            <div class="col-md-3">
                    <?php include ($adminPositionsDir . "column_left.tpl");	?>
            </div>

            <div class="col-md-6">
                    <?php include ($adminPositionsDir . "content_top.tpl");	?>

                    <?php include ($adminPositionsDir . "content_bottom.tpl"); ?>
            </div>

            <div class="col-md-3">
                    <?php include ($adminPositionsDir . "column_right.tpl"); ?>
            </div>
    </div>
</div>
<?php if($show_position) { ?>
<div class="custom bottom row">
    <div class="col-md-12">
        <?php include ($adminPositionsDir . "custom_bottom.tpl");	?>
    </div>
</div>
<div class="footer">
    <div class="row">
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "FooterTop1.tpl");	?>
           
        </div>
        <div class="col-md-4">
            <?php include ($adminPositionsDir . "FooterTop2.tpl");	?>
        </div>
        <div class="col-md-4">
           <?php include ($adminPositionsDir . "FooterTop3.tpl");	?>
        </div>	
    </div>	
    <div class="row">
        <div class="col-md-3">
            <?php include ($adminPositionsDir . "FooterCenter1.tpl");	?>
        </div>
        <div class="col-md-3">
                <?php include ($adminPositionsDir . "FooterCenter2.tpl");	?>
        </div>
        <div class="col-md-3">
            <?php include ($adminPositionsDir . "FooterCenter3.tpl");	?>
        </div>	
        <div class="col-md-3">
            <?php include ($adminPositionsDir . "FooterCenter4.tpl");	?>
        </div>	
    </div>
    <div class="row">
        <div class="col-md-6">
            <?php include ($adminPositionsDir . "FooterCopy1.tpl");	?>
        </div>
        <div class="col-md-6">
           <?php include ($adminPositionsDir . "FooterCopy2.tpl");	?>
        </div>
    </div>
</div>
<?php } ?>