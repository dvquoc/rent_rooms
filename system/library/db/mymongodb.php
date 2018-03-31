<?php
namespace DB;

final class MyMONGODB {
	private $link;
	public function __construct($hostname, $username, $password, $database, $port = '27017') {
        $connect = new \MongoDB\Client("mongodb://{$hostname}:{$port}");
        $this->link = $connect ->selectDatabase($database);
	}
}