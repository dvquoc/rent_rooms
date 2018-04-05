<?php echo $header; ?>
<script src="/public/assets/plugins/slide_reveal/slidereveal.js" type="text/javascript"></script>
<div class="list">
    <div class="container">
        <?php if(!empty($rooms)) { ?>
            <?php foreach($rooms as $item) { ?>
                <div class="item-rooms">
                    <h3><?php echo $item['name'] ?></h3>
                </div>
            <?php } ?>
        <?php } ?>
    </div>
</div>
<?php echo $footer; ?>

