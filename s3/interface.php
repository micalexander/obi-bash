<?php

require 'S3.php';

$s3 =  new S3('AKIAJ4QBS5NE4YCFHKUA', '9I2qKuq022dm/bNlqvekdMx02+23Pg8AhT4Kg99H');

S3::putObject(
	$s3->inputFile($argv[1], false),
	'micalexander',
	$argv[1],
	S3::ACL_PUBLIC_READ,
	array(),
	array(),
	S3::STORAGE_CLASS_STANDARD
);

?>