<ul id="menu">
    <li id="dashboard"><a href="<?php echo $home; ?>"><i class="fa fa-dashboard fa-fw"></i> <span><?php echo $text_dashboard; ?></span></a></li>

    <li id="rooms"><a href="<?php echo $rooms; ?>"><i class="fa fa-building"></i> <span><?php echo $text_rooms; ?></span></a></li>

    <li><a class="parent"><i class="fa fa-user"></i> <span>Quản lý địa lý</span></a>
        <ul>
            <li><a href="<?php echo $district; ?>">Quản lý Quận/Huyện</a></li>
            <li><a href="<?php echo $street; ?>">Quản lý đường phố</a></li>
            <li><a href="<?php echo $special; ?>">Khu vực đặc biệt</a></li>
        </ul>
    </li>

    <li id="system"><a class="parent"><i class="fa fa-cog fa-fw"></i> <span><?php echo $text_system; ?></span></a>
        <ul>
          <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
          <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
        </ul>
    </li>
    <li><a class="parent"><i class="fa fa-user"></i> <span><?php echo $text_users; ?></span></a>
        <ul>
            <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
            <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
        </ul>
    </li>
    <li><a type="button" id="button-menu"><i class="fa fa-indent fa-lg"></i> <span>Ẩn hiện menu</span></a></li>
</ul>
