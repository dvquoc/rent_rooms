<?php
/**
 * User: doanvanquoc
 * Date: 6/28/2017
 * Time: 11:35 PM
 * Description: Dùng để định nghĩa các object trong project
 */
$GLOBALS['default_object_project']=array(
    'projects'=>array(
        'alias_name'    =>'projects',
        'meta_array'    =>array(
            'tab_1'     =>array(
                'project_link'=>array(
                    'type'=>'hidden',
                    'required'=>false,
                    'data_default'=>'',
                )
            ),
            'tab_data'  =>array(
                'project_news_relatevie'=>array(
                    'type'=>'autocomplete',
                    'required'=>false,
                    'data_default'=>'',
                    'type_object_relative' =>'news'
                ),
                'project_local'=>array(
                    'type'=>'text',
                    'required'=>false,
                    'data_default'=>'',
                ),
                'project_date_start'=>array(
                    'type'=>'text',
                    'required'=>false,
                    'data_default'=>'',
                )
            )
        ),
        'have_category' => true,
        'have_tag'      => true,
        'page_setting'  => true,
        'alias_url'     => array(
            'type' => array( // Định nghĩa url cho type của object;
                'router_page'   => 'object_projects/projects',
                'request_id'  => 'type_id',
                'prefix_alias'  =>'projects-type-prefix-',
            ),
            'category' => array(
                'router_page' => 'object_projects/projects',
                'request_id' => 'path_id',
                'prefix_alias' =>'projects-category-prefix-',
            ),
            'tag'=>array(
                'router_page' => 'page/tag_projects',
                'request_id' => 'tag_id',
                'prefix_alias' =>'projects-tag-prefix-',
            ),
            'information' => array(
                'router_page' => 'object_projects/detail',
                'request_id' => 'information_id',
                'prefix_alias' =>'projects-prefix-',
            ),
        ),
        'meta' => array(
            'title' => 'Tất cả dự án',
            'description' =>'Mô tả cho dự án',
            'keyword' =>'dự án, dự án vinhome group',
        )
    ),
    'news'=>array(
        'alias_name'    => 'news',
        'meta_array'    => array(
            'tab_1' => array()
        ),
        'have_category' => true,
        'have_tag'      => true,
        'page_setting'  => true,
        'alias_url'     => array(
            'type' => array( // Định nghĩa url cho type của object;
                'router_page'   => 'object_news/news',
                'request_id'  => 'type_id',
                'prefix_alias'  =>'news-type-prefix-',
            ),
            'category'=> array(
                'router_page' => 'object_news/news',
                'request_id' => 'path_id',
                'prefix_alias' =>'news-category-prefix-',
            ),
            'tag'=>array(
                'router_page' => 'page/tag_news',
                'request_id' => 'tag_id',
                'prefix_alias' =>'news-tag-prefix-',
            ),
            'information'=>array(
                'router_page' => 'object_news/detail',
                'request_id' => 'information_id',
                'prefix_alias' =>'news-prefix-',
                'checked' => true,
            ),
        ),
        'meta' => array(
            'title' => 'Tất cả tin tức',
            'description' =>'Mô tả cho tin tức',
            'keyword' =>'Tin tức mới nhất, cập nhật tin tức mới nhất',
        )
    ),
    'bussiness'=>array(
        'alias_name'    => 'bussiness',
        'meta_array'    => array(
            'tab_1'     => array()
        ),
        'have_category' => false,
        'have_tag'      => true,
        'page_setting'  => false,
        'alias_url'     =>array(
            'type' => array( // Định nghĩa url cho type của object;
                'router_page'   => 'information_type/information',
                'request_id'  => 'type_id',
                'prefix_alias'  =>'bussiness-type-prefix-',
            ),
            'tag'=>array(
                'router_page' => 'page/tag_bussiness',
                'request_id' => 'tag_id',
                'prefix_alias' =>'bussiness-tag-prefix-',
            ),
            'information'=>array(
                'router_page' => 'information/information',
                'request_id' => 'information_id',
                'prefix_alias' =>'bussiness-prefix-',
            ),
        ),
        'meta' => array(
            'title' => 'Tất cả tin tức doanh nhân',
            'description' =>'Mô tả cho Doanh nhân',
            'keyword' =>'Doanh nhân, thông tin doanh nhân, Doanh nhân nổi tiếng',
        )
    ),
    'events'=>array(
        'alias_name' =>'events',
        'meta_array'    => array(
            'tab_1'     => array()
        ),
        'have_category' => false,
        'have_tag'      => true,
        'page_setting'  => false,
        'alias_url'     => array(
            'type'=>array( // Định nghĩa url cho type của object;
                'router_page'   => 'information_type/information',
                'request_id'  => 'type_id',
                'prefix_alias' =>'events-type-prefix-',
            ),
            'tag'=>array(
                'router_page' => 'page/tag_events',
                'request_id' => 'tag_id',
                'prefix_alias' =>'events-tag-prefix-',
            ),
            'information'=>array(
                'router_page' => 'information/information',
                'request_id' => 'information_id',
                'prefix_alias' =>'events-prefix-',
            ),
        ),
        'meta' => array(
            'title' => 'Tất cả sự kiện',
            'description' =>'Mô tả cho sự kiện',
            'keyword' =>'sự kiện, thông sự kiện, Các sự kiện hot nhất',
        )
    ),
    'videos'=>array(
        'alias_name' =>'videos',
        'meta_array'    => array(
            'block_media'     => array(
                'videos_link'=>array(
                    'type'=>'text',
                    'required'=>false,
                    'data_default'=>'',
                )
            )
        ),
        'have_category' => false,
        'have_tag'      => true,
        'page_setting'  => false,
        'alias_url'     => array(
            'type'=>array( // Định nghĩa url cho type của object;
                'router_page'   => 'information_type/information',
                'request_id'  => 'type_id',
                'prefix_alias' =>'videos-type-prefix-',
            ),
            'tag'=>array(
                'router_page' => 'page/tag_videos',
                'request_id' => 'tag_id',
                'prefix_alias' =>'videos-tag-prefix-',
            ),
            'information'=>array(
                'router_page' => 'information/information',
                'request_id' => 'information_id',
                'prefix_alias' =>'videos-prefix-',
            ),
        ),
        'meta' => array(
            'title' => 'Tất cả video',
            'description' =>'Mô tả cho video',
            'keyword' =>'Cập nhật video, thông tin video, video mới nhất',
        )
    ),
    'relative'=>array( // Các bài viết liên quan - Giới thiệu.
        'alias_name' =>'relative',
        'have_category' => false,
        'have_tag'      => true,
        'page_setting'  => false,
        'alias_url'     => array(
            'type'=>array( // Định nghĩa url cho type của object;
                'router_page'   => 'information_type/information',
                'request_id'  => 'type_id',
                'prefix_alias' =>'relative-type-prefix-',
            ),
            'tag'=>array(
                'router_page' => 'page/tag_relative',
                'request_id' => 'tag_id',
                'prefix_alias' =>'relative-tag-prefix-',
            ),
            'information'=>array(
                'router_page' => 'information/information',
                'request_id' => 'information_id',
                'prefix_alias' =>'relative-prefix-',
            ),
        ),
        'meta' => array(
            'title' => 'Các bài viết liên quan',
            'description' =>'Mô tả cho bài viết liên quan',
            'keyword' =>'Bài viết liên quan, thông tin website',
        )
    ),
);

