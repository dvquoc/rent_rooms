<?php
class ControllerPartPagination extends Controller
{
    private $error = array();
    public function index($data_input)
    {
        $data = array();
        $text_pagination  = 'Hiển thị từ %d đến %d của %d (%d Trang)';
        $page = isset($this->request->get['page']) ? $this->request->get['page']: 1;
        $total = $data_input['total'];
        $limit = isset($data_input['limit'])? $data_input['limit']: $this->config->get('config_limit_admin');
        $url = isset($data_input['url']) ? '&'.$data_input['url']: '';
        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->url = $this->url->link($this->request->get['route'], 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
        $data['pagination'] = $pagination->render();
        $data['results'] = sprintf($text_pagination, ($total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($total - $limit)) ? $total : ((($page - 1) * $limit) + $limit), $total, ceil($total / $limit));
        return $data;
    }
}