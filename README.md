# Obi Version 2.0

Obi is a project management tool that simplifies WordPress development.

THIS VERSION HAS BEEN DEPRECATED SEE [HERE](https://github.com/micalexander/obi) FOR THE UPDATED VERSION

## Installation:

1. If you haven't already, create a folder named "bin" and a file named ".bash_profile" with the following text on it `export PATH=$HOME/bin/obi:$PATH`, and place them **separately** in your home directory root folder.

2. Next, you'll need to find out which PHP and MySQL your system is using. This can be done with the terminal command `which`. To do this first run `which php` from the terminal. If you are presented with a path ending with php, then the location your systems PHP is available to Obi and you are good to go. Now run `which mysql` from the terminal. If you are presented with a path ending with mysql, then the location your systems MySQL is available to Obi and you can move on to step 3.

    If **either** command, `which php` or `which mysql` do not yield a path then you will need to install or locate which ever one that didn't show up. After you have verified that PHP and MySQL are both running on your system, you can run the `which` command again. If you have verified that either of the two are correctly installed and the `which` command still won't yield a path then you will need to add the unyielded location for the corresponding service to your ".bash_profile" like shown below replacing the placeholder path with your system's path.

        export PATH=/path/to/your/systems/php/folder:$PATH
        export PATH=/path/to/your/systems/mysql/folder:$PATH

    If you are running **MAMP PRO** your PHP will be located at `/Applications/MAMP/bin/PHP/[mampphpversion]/bin` (where you would replace [mampphpversion] with the version of PHP MAMP PRO is running) and MySQL will be located at `/Applications/MAMP/Library/bin`.

    So say your **MAMP PRO** is running PHP version 5.4.4, you would need to add the lines below to your ".bash_profile" below the line in step one.

        export PATH=/Applications/MAMP/bin/PHP/php5.4.4/bin:$PATH
        export PATH=/Applications/MAMP/Library/bin:$PATH

3. To ensure that the changes to your ".bash_profile" are available, run the following command.

        source ~/.bash_profile

4. Assuming you already have Git installed run this command from your terminal:

    `cd $HOME/bin/ ; git clone https://github.com/micalexander/obi.git`

    And then run:

    `obi config`

    Enter your setting and you're ready to go.

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

## Getting started

### Global config

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

`wp-enabled`: obi will use the credentials that are on the [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) file.

`disabled`: obi will not use any credentials

### Project specific config

Obi has some features that require a project specific config file to be configured correctly in order to make use of them. The features that rely on this config file are listed below along with their uses.

    SSH - used for rsync and to import/dump databases through SSH (decreasing the transfer time)
    RSync - used to sync directories to and from a remote server
    S3 - used to send database backups to S3

Whenever the command `obi [-e,-g,-w] [project_name]` is ran, Obi will create a hidden directory in the root of the newly created project. This folder is rightfully named .obi, and contains file named config. This file is used to store the setting for each of the previously described features.

The default settings are as follows:

    #
    # Production ssh settings
    #
    enable_production_ssh='0'
    production_ssh='0'
    production_remote_project_root='0'
    enable_production_sshmysql='0'

    #
    # Staging ssh settings
    #
    enable_staging_ssh='0'
    staging_ssh='0'
    staging_remote_project_root='0'
    enable_staging_sshmysql='0'

    #
    # S3 settings
    #
    enable_S3='0'
    public_key='0'
    secret_key='0'
    mybucket='0'

    #
    # RSync settings
    #
    enable_rsync='0'
    rsync_dirs=('/change/this/to/first/sync/directory/' '/change/this/to/second/sync/directory/or/remove/entirely/')

By default when this file is created all the settings are not set (set to 0, with the exception of rsync_dirs which has instructional placeholder text). All of these settings can be changed directly when necessary. These settings will be explained in more depth in its respected sections below.

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

With Obi there are two ways to back up a MySQL database. One is just a straight backup to a .sql file that is then placed in its respected folder in the _resources/dumps directory. The second is a backup to a .sql file that is placed in its respected directory as a backup and then imported it into the MySQL database specified when running the `obi -b` command. The latter of the two will also perform a find and replace on the URLs that are stored in the .sql file with the destination URL that is stored in the [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) file before it's imported to it's destination database.

After running `obi config` to ensure your environment settings are correct, Obi will be ready to backup your databases. To backup a database you can run the following commands below by replacing the [project_name] with your project name and the [environment] with your desired environment:

`obi -b [project_name] [environment]`

Example of a backup of the local database

    `obi -b myproject -l`

To sync two MySQL databases you can run the following commands below by replacing the [project_name] with your project name and the [environment(s)] with your desired environment(s):

`obi -b [project_name] [environment(s)]`

Example of a backup of the local database with a find and replace followed by an import to the production database

    `obi -b myproject -ltp`

Obi also handles the import of database files. There are two ways to accomplish this. One is just a straight import of a .sql file by explicitly providing the file path. The second is a import of a .sql file without providing the file path. If the file path is not provided then obi will look in the _resources/dumps/[environment(s)] directory for the last modified file to be used. By suppling two environments Obi will perform a find and replace on the URLs that are stored in the .sql file with the destination URL that is stored in the [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) file before it's imported to it's destination database.

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

By default Obi looks in the [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) for the URLs to find and replace

## wp-config.PHP

Obi relies on a special [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) file to perform it's find and replace function and any other of its MySQL tasks. This file is included in the [KLAS Wordpress Theme Framework](https://github.com/micalexander/mask) when running the `-w` argument.

When the `-w` argument is used to create a WordPress enabled and git working directory, the `project_name` that is entered is also used in the [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) and throughout the [KLAS Wordpress Theme Framework](https://github.com/micalexander/mask), changing the theme name from its default of klas to the  `project name` you entered as well as in other places that are necessary. Obi will also use this to change the table_prefix from wp_ to the first three letters of the `project_name`.

Obi will set the staging_tld (used to detect if Wordpress is on the staging server) to what ever the `stagingdomain` in the .obiconfig file is set to.

Salts are also added to the [wp-config.PHP](https://github.com/micalexander/mask/blob/master/wp-config.PHP) file automatically.


## SSH

When Obi is is used in combination with ssh, MySQL interactions become **much faster** and the ability RSync local and remote directories become possible. One thing to note is that Obi relies on an SSH alias for the sever to be set in order for SSH to work. Once your environments SSH alias is set, to enable Obi's SSH feature navigate to the the `.obi/config` file and locate the sections the resembles the ones below.

    #
    # Production ssh settings
    #
    enable_production_ssh='0'
    production_ssh='0'
    production_remote_project_root='0'
    enable_production_sshmysql='0'

    #
    # Staging ssh settings
    #
    enable_staging_ssh='0'
    staging_ssh='0'
    staging_remote_project_root='0'
    enable_staging_sshmysql='0'

Each environment has its own settings. To enable production SSH settings the `enable_production_ssh='0'` must be enabled be replacing the 0 with a 1 as shown below.

    enable_production_ssh='1'

To enable staging SSH settings the `enable_staging_ssh='0'` must be enabled by replacing the 0 with a 1 as shown below.

    enable_staging_ssh='1'

After the the desired environment SSH setting is enabled the next thing to do is pass the SSH alias to the `staging_ssh='0'` or `production_ssh='0'` setting. Examples given below.

    staging_ssh='mystaging'

or

    production_ssh='myproduction'

Once the SSH alias has been added to the config file the next step is to enter the absolute path to the servers site directory **with** the leading but **without** the trailing slash as shown below. This step is **essential** for RSync to work correctly.


    production_remote_project_root='/my/absolute/production/path'

or

    staging_remote_project_root='/my/absolute/staging/path'

The last step is for mysql. To enable production SSH MySQL settings the `enable_production_sshmysql='0'` must be enabled by replacing the 0 with a 1 as shown below.

    enable_production_sshmysql='1'

To enable staging SSH MySQL settings the `enable_staging_sshmysql='0'` must be enabled by replacing the 0 with a 1 as shown below.

    enable_staging_sshmysql='1'


## RSync (Syncing Remote and Local Directories)

Obi can be used to sync local and remote directories. To use this feature the SSH feature (explained above) **must** be enabled along with the RSync settings that resemble the section below. Both of these settings are located in the `.obi/config` file that is in the root of your project working directory.

    #
    # RSync settings
    #
    enable_rsync='0'
    rsync_dirs=('/change/this/to/first/sync/directory/' '/change/this/to/second/sync/directory/or/remove/entirely/')

Before Obi will sync two directories the `enable_rsync='0'` setting must be enabled be replacing the 0 with a 1 as shown below.

    enable_rsync='1'

The `rsync_dirs=('/change/this/to/first/sync/directory/' '/change/this/to/second/sync/directory/or/remove/entirely/')` setting is used to tell Obi which directory(s) to sync. In-between the parenthesis is where the directory(s) need to be placed. Each directory must be placed between a set of single quotes with the leading and trailing forward slash and there needs to be a space between each directory as in the format displayed above. Although in the example above there are multiple directories shown for demonstration purposes, one directory can be synced simply by removing the second directory as shown below.

    rsync_dirs=('/change/this/path/to/your/sync/directory/')


## S3 Backups

The S3 feature is designed to automatically send database backup files to S3. Whenever a MySQL database is dumped or imported, Obi will look in the corresponding database directory and grab all the files older than 30 days, gzip them, append the date to them and send them off to S3. In order to take advantage of this feature, it must first be enabled in the `.obi/config` file that is in the root of your project working directory. The section that handles this feature will resemble the section below.

    #
    # S3 settings
    #
    enable_S3='0'
    public_key='0'
    secret_key='0'
    mybucket='0'

To enable sS settings the `enable_S3='0'` must be enabled by replacing the 0 with a 1 as shown below.


    enable_S3='1'

The next three setting should speak for them-self. Once you have enabled Obi's S3 settings enter your S3 credentials in the spaces provided replacing the 0 with your S3 credentials as shown below

    public_key='my-public-key'
    secret_key='my-secret-key'
    mybucket='my-bucket-name'

## Examples:

`obi -e myproject`: This tells Obi to create an empty working directory named myproject.

`obi -b -ltp`: This tells Obi to make a backup of local and import it into the production database.

### Dependencies

- Git (duh!)
- Uses the [MASK Wordpress Theme Framework](https://github.com/micalexander/mask) - A SASS based starter theme for WordPress.
