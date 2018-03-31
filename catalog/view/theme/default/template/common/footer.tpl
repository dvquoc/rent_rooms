<footer>

  <div class="suport-footer">
    <div class="container">
      <div class="row">
          <div class="col-md-4">
            <h3 class="title-footer hidden"><span>Thông tin</span></h3>
            <div class="logo-footer row">
              <div class="col-md-4"><img style="background-color: #fff;border-radius: 3px;" src="/image/cache/catalog/doi_tac/logo175x150px-150x100.png" alt="RedBull" class="img-responsive"></div>
              <div class="col-md-4"><img style="background-color: #fff;border-radius: 3px;" src="/image/cache/catalog/doi_tac/LogoVinDs-150x100.png" alt="RedBull" class="img-responsive"></div>
              <div class="col-md-4"><img style="background-color: #fff;border-radius: 3px;" src="/image/cache/catalog/doi_tac/vinhomes-150x100.png" alt="RedBull" class="img-responsive"></div>
            </div>
          </div>
          <div class="col-md-8">
            <div class="address">
              <div class="title-company">
                <h3 class="text-left">VIN HOME GROUP</h3>
              </div>
              <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.</p>
            </div>
          </div>

      </div>
      <div class="row">
        <div class="col-md-6">
          <p><i class="fa fa-home"></i> LA-01.05 Lexington, 67 Mai Chí Thọ, Quận 2, TP. Hồ Chí Minh</p>
        </div>
        <div class="col-md-3">
          <p><span class="fa fa-envelope"></span> info@phuhoangland.vn</p>
        </div>
        <div class="col-md-3">
          <p><span class="fa fa-globe"></span> https://www.phuhoangland.vn</p>
        </div>
      </div>
      <div>
      <div class="menu-footer">
        <div><a href="du-an/vinhomes.html">Vinhomes</a></div>
        <div><a href="du-an/vinpearl-villas.html">Vinpearl Villas</a></div>
        <div><a href="du-an/vinpearl-condotel.html">Vinpearl Condotel</a></div>
        <div><a href="/su-kien.html">Sự Kiện</a></div>
        <div><a href="/tin-tuc.html">Tin tức</a></div>
        <div><a href="/doanh-nhan.html">Doanh nhân</a></div>
        <div style="flex-grow: 1; text-align: right; "><a href="tel:0901 777 667" style="padding-right:0; font-weight: bold; color: #fff; font-size: 18px">0901 777 667 <span style="font-size: 18px; border:1px solid #fff; padding:5px; margin-left:5px; background-color:#111" class="fa fa-phone"></span> </a></div>
      </div>
      </div>
    </div>
  </div>
  <div class="copy-right">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
            <p class="text-left">
              Copyright &copy; Vlineweb 20017 <br>
            </p>
        </div>
        <div class="col-md-6 text-right">

          <div class="list-social" style="margin: auto">
            <ul class="list">
              <li>
                <a href="https://www.facebook.com" target="_blank">
                  <i class="fa fa-facebook"></i>
                </a>
              </li>
              <li>
                <a href="https://www.facebook.com" target="_blank">
                  <i class="fa fa-google-plus"></i>
                </a>
              </li>
              <li>
                <a href="https://www.facebook.com" target="_blank">
                  <i class="fa fa-youtube"></i>
                </a>
              </li>
            </ul>
          </div>
        </div>

      </div>
    </div>
  </div>
  <div class="support-24-7">
    <div class="list-support hidden">
      <ul class="phome_menu">
          <li>
            <a href="tel: 0909 35 31 37" onclick="return ga_call_hotline()" title="Gọi tư vấn viên Võ Thái Thảo">
              <div class="supporter_image"><img src="http://1p.com.vn/wp-content/uploads/2017/03/team-member-thao.jpg" alt="Gọi tư vấn viên Võ Thái Thảo"> </div>
              <div class="text-phone"><span> 0909 35 31 37</span></div>
            </a>
          </li>
        <li>
            <a href="tel: 0931 34 34 97" onclick="return ga_call_hotline()" title="Gọi tư vấn viên Phạm Nguyễn Vân Anh">
              <div class="supporter_image"><img src="http://1p.com.vn/wp-content/uploads/2017/03/3f-van-anh.jpg" alt="Gọi tư vấn viên Phạm Nguyễn Vân Anh"> </div>
              <div class="text-phone"><span> 0931 34 34 97</span></div>
            </a>
          </li>
      </ul>
    </div>
    <a class="icon_animation_2 icon-support" href="javascript:;"></a>
  </div>
  <script src="/public/assets/js/function.js" type="text/javascript"></script>
  <script src="/public/assets/js/common.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      $('li.dropdown').hover(function() {
        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(300);
      }, function() {
        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(300);
      });

      var list_support=$('.list-support').html();
      $('.icon-support').popover({
        html:true,
        placement: 'left',
        title: "Hỗ trợ 24/7",
        content: list_support,
        animation: true,
        trigger:"click"
      });

      var  mn = $("#menu-main");
      hdr = mn.offset().top;
      $(window).scroll(function() {
        if( $(this).scrollTop() > hdr && false ) {
          mn.addClass('navbar-fixed-top');
        } else {
          if(!$('body').hasClass('common-home'))
            mn.removeClass('navbar-fixed-top');
        }
      });
      console.log("%c ♥ Xin chào %c : Vlinewebs","color: #d22; font-size:36px; font-weight:bold; ","color: blue; font-size:36px;");
    });
  </script>
</footer>
</body></html>