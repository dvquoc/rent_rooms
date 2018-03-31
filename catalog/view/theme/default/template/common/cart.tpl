<div id="cart" class="btn-group btn-block">
  <button type="button" data-toggle="modal" data-target="#vline_cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-inverse btn-block btn-lg dropdown-toggle cart-vline">
    <i class="fa fa-shopping-cart"></i>
    <span id="cart-total"><?php echo $text_items; ?></span>
  </button>
  <div class="modal fade" id="vline_cart">
    <div class="modal-dialog" role="document">
      <div class="modal-content" id="content_vline_cart">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h3 class="modal-title" id="myModalLabel">Mua mẫu có sẵn</h3>
          </div>
          <div class="modal-body">
            <?php if ($products || $vouchers) { ?>
                <?php foreach ($products as $product) { ?>
                  <div class="row item-product-of-cart">
                      <div class="col-md-2"><?php if ($product['thumb']) { ?>
                      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                      <?php } ?></div>
                      <div class="col-md-5">
                      <a href="<?php echo $product['href']; ?>"><b><?php echo $product['name']; ?></b></a>
                      <?php if ($product['option']) { ?>
                      <?php foreach ($product['option'] as $option) { ?>
                      <br />
                      - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
                      <?php } ?>
                      <?php } ?>
                      <?php if ($product['recurring']) { ?>
                      <br />
                      - <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
                      <?php } ?></div>
                      <div class="col-md-5"><?php echo $product['total']; ?></div>
                      <button type="button" onclick="cart.remove('<?php echo $product['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs remove-item-product"><i class="fa fa-times"></i></button>
                  </div>
                <?php } ?>
                <?php foreach ($vouchers as $voucher) { ?>
                <div>
                  <td class="text-center"></td>
                  <td class="text-left"><?php echo $voucher['description']; ?></td>
                  <td class="text-right">x&nbsp;1</td>
                  <td class="text-right"><?php echo $voucher['amount']; ?></td>
                  <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
                </div>
                <?php } ?>
              <div class="total-list">
                  <?php foreach ($totals as $total) { ?>
                  <div class="row item-total">
                    <div class="col-lg-6 text-left"><strong><?php echo $total['title']; ?></strong></div>
                    <div class="col-lg-6 text-right"><?php echo $total['text']; ?></div>
                  </div>
                  <?php } ?>
                <div class="text-center">
                  <a class="btn-checkout text-center" href="<?php echo $checkout; ?>"><strong><i class="fa fa-share"></i> <?php echo $text_checkout; ?></strong></a>
                  Hoặc
                  <a class="btn-checkout text-center" href="<?php echo $checkout; ?>"><strong><i class="fa fa-share"></i> Đăng ký dùng thử</strong></a>
                </div>
              </div>
            <?php } else { ?>
              <div class="empty-cart">
                <p class="text-center"><?php echo $text_empty; ?></p>
              </div>
            <?php } ?>
          </div>
      </div>
    </div>
  </div>
</div>
