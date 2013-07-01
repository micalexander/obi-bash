<?php

require 'S3.php';

$s3 =  new S3( $argv[1], $argv[2]);

S3::putObject(
	$s3->inputFile($argv[3], false),
	$argv[4],
	$argv[3],
	S3::ACL_PUBLIC_READ,
	array(),
	array(),
	S3::STORAGE_CLASS_STANDARD
);

?>