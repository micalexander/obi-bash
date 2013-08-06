# Obi

Obi is a all-in-one tool designed to make project management, WordPress development, MySQL database backups and syncing MySQL databases between multi-environments a breeze.

## Installation:

If you haven't already, create a folder named "bin" and a file named ".bash_profile" with the following text on it `export PATH=$HOME/bin/obi:$PATH`, and place them **separately** in your home directory root folder. Assuming you already have Git installed run this command from your terminal:

`cd $HOME/bin/ ; git clone https://github.com/micalexander/obi.git`

Run:

`obi config`

Enter your setting and thats it.

## Useage:

`obi` `[argument]`

or

`obi` `[argument]` `[project_name]` `[environment(s)]`

### Arguments:

`config`: configure obi

`help`: prints usage to the terminal

`mysql`: login mysql database  *(Followed by the `[environment(s)]`)*

`kill`: Remove a working directory completely *(Followed by the `[project_name]`)*

`-e`: Create an empty working directory *(Followed by the `[project_name]`)*

`-g`: Create a git repository working directory *(Followed by the `[project_name]`)*

`-w`: Create a WordPress enabled git working directory *(Followed by the `[project_name]`)*

`-b`: Backup mysql database *(Followed by the `[project_name]` and then the `[environment(s)]`)*

### Project name:

`[project_name]` : Name of the directory that contains your project.

### Environments:

`-l`: local

`-s`: staging

`-p`: production

`-lts`: local to staging

`-ltp`: local to production

`-stl`: staging to local

`-stp`: staging to production

`-ptl`: production to local

`-pts`: production to staging

## Configuration

When the command `obi`... is ran for the first time, a single hidden file is generated in your home directory with the name .obiconfig. **Please do not edit this file directly.** This file is used by obi to store the path to your local projects directory that contains all of your projects along with your multiple environment settings.

**To edit this file** simply run the command `obi config`.

The default settings are as follows:

	localprojectdirectory='0'
	localsettings='enabled'
	localhost='localhost'
	localuser='root'
	localpassword='root'

	stagingsettings='disabled'
	stagingdomain='0'
	staginghost='0'
	staginguser='0'
	stagingpassword='0'

	productionsettings='disabled'
	productiondomain='0'
	productionhost='0'
	productionuser='0'
	productionpassword='0'


By default when this file is created the `localprojectdirectory` variable is not set (set to 0) and before obi can be used, it needs to be set to your local projects directory as a direct path without the trailing slash. The `localsettings` by default are set to enabled and the `stagingsettings` and `productionsetttings` to disabled.

The `localsettings`, `stagingsettings` and `productionsetttings` control how obi will access your MySQL credentials. The three possible settings are:

	enabled
	wp-enabled
	disabled

`enabled`: obi will use the credentials that are set below it.

`wp-enabled`: obi will use the credentials that are on the [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) file.

`disabled`: obi will not use any credentials

## Working Directory

The directory structure below is automatically generated when using the `-e`, `-g` or `-w` arguments, followed by the `project-name`. This way it is very easy to stay organized.

The _resource directory is essential to obi's functionality. This is primarily because contains the dumps directory. The dumps directory is used when backing up MySQL databases with the argument `-b` and the import of MySQL databases with the argument `-i` followed by the `project-name` and then the `[environment(s)]`. Theses backups are then placed in its environment folder respectively. The root directory is where WordPress is installed when using the argument `-w` followed by the `project-name`.

    project-name
        |
        |--_resources
        |    |
        |    |
        |    |-- assets
        |    |    |
        |    |    |-- ai
        |    |    |-- architecture
        |    |    |-- content
        |    |    |-- emails
        |    |    |-- estimates
        |    |    |-- fonts
        |    |    |-- gif
        |    |    |-- jpg
        |    |    |-- png
        |    |    |-- pdf
        |    |    |-- psd
        |    |
        |    |-- dumps
        |		  |-- local
        |		  |-- production
        |		  |-- staging
        |		  |-- temp
        |
        |--.obi
        |
    site-root


## Database Backups

With Obi there are two ways to back up a MySQL database. One is just a straight backup to a .sql file that is then placed in its respected folder in the _resources/dumps directory. The second is a backup to a .sql file that is placed in its respected directory as a backup and then imported it into the MySQL database specified when running the `obi -b` command. The latter of the two will also perform a find and replace on the URLs that are stored in the .sql file with the destination URL that is stored in the [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) file before it's imported to it's destination database.

After running `obi config` to ensure your environment settings are correct, Obi will be ready to backup your databases. To backup a database you can run the following commands below by replacing the [project_name] with your project name and the [environment] with your desired environment:

`obi -b [project_name] [environment]`

Example of a backup of the local database

    `obi -b myproject -l`

To sync two MySQL databases you can run the following commands below by replacing the [project_name] with your project name and the [environment(s)] with your desired environment(s):

`obi -b [project_name] [environment(s)]`

Example of a backup of the local database with a find and replace followed by an import to the production database

    `obi -b myproject -ltp`

Obi also handles the import of database files. There are two ways to accomplish this. One is just a straight import of a .sql file by explicitly providing the file path. The second is a import of a .sql file without providing the file path. If the file path is not provided then obi will look in the _resources/dumps/[environment(s)] directory for the last modified file to be used. By suppling two environments Obi will perform a find and replace on the URLs that are stored in the .sql file with the destination URL that is stored in the [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) file before it's imported to it's destination database.

After running `obi config` to ensure your environment settings are correct, Obi will be ready to import your databases. To import a database you can run the following commands below by replacing the [project_name] with your project name and the [environment] with your desired environment:

`obi -i [project_name] [environment]`

Example of an import into the local database

    `obi -i myproject -l`

Example of an import into the local database by providing a file path

    `obi -i myproject -l /path/to/the/file.sql`

To sync two MySQL databases you can run the following commands below by replacing the [project_name] with your project name and the [environments] with your desired environments:

`obi -i [project_name] [environments]`

Example of an import into the local database with a find and replace followed by an import to the production database
week
    `obi -i myproject -ltp`

Example of an import into the local database with a find and replace followed by an import to the production database by providing a file path

    `obi -i myproject -ltp /path/to/the/file.sql`

By default Obi looks in the [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) for the URLs to find and replace

## wp-config.php

Obi relies on a special [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) file to perform it's find and replace function and any other of its MySQL tasks. This file is included in the [KLAS Wordpress Theme Framework](https://github.com/micalexander/mask) when running the `-w` argument.

When the `-w` argument is used to create a WordPress enabled and git working directory, the `project_name` that is entered is also used in the [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) and throughout the [KLAS Wordpress Theme Framework](https://github.com/micalexander/mask), changing the theme name from its default of klas to the  `project name` you entered as well as in other places that are necessary. Obi will also use this to change the table_prefix from wp_ to the first three letters of the `project_name`.

Obi will set the staging_tld (used to detect if Wordpress is on the staging server) to what ever the `stagingdomain` in the .obiconfig file is set to.

Salts are also added to the [wp-config.php](https://github.com/micalexander/mask/blob/master/wp-config.php) file automatically.

## Syncing Remote and Local Directories

## S3 Backups

##

## Examples:

`obi -e myproject`: This tells Obi to create an empty working directory named myproject.

`obi -b -ltp`: This tells Obi to make a backup of local and import it into the production database.

### Dependencies

- Git (duh!)
- Uses the [KLAS Wordpress Theme Framework](https://github.com/micalexander/mask) - A SASS based starter theme for WordPress.
