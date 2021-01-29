#----------------------------------------------------------------------------
#  Copyright (c) 2021 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

class ob_common::params {

  $packages = ['unzip']

  # User details
  $user           = 'wso2carbon'
  $user_group     = 'wso2'
  $user_id        = 802
  $user_group_id  = 802

  # JDK distributions
  $jdk_version = 'JDK_TYPE'
  $java_dir     = '/opt'
  $java_symlink = "${java_dir}/java"

  if $jdk_version == 'Oracle_JDK8' {
    $jdk_file_name = "jdk-8u161-linux-x64.tar.gz"
    $jdk_name = "jdk1.8.0_161"
  } elsif $jdk_version == 'OPEN_JDK8' {
    $jdk_file_name = "jdk-8u192-ea-bin-b02-linux-x64-19_jul_2018.tar.gz"
    $jdk_name = "jdk1.8.0_192"
  } elsif $jdk_version == 'ADOPT_OPEN_JDK11' {
    $jdk_type = "OpenJDK11U-jdk_x64_linux_hotspot_11.0.5_10.tar.gz"
    $jdk_path = "jdk-11.0.5+10"
  }

  $java_home    = "${java_dir}/${jdk_name}"


  $wso2_service_name  = "wso2${profile}"
  $version            = '2.0.0'


  $target         = '/mnt'
  $product_dir    = "${target}/${profile}"
  $pack_dir       = "${target}/${profile}/packs"


  # Profile configurations
  case $profile {
    'obiam': {
      $pack               = "wso2-obiam-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2carbon.pid"
    }
    'obam': {
      $pack               = "wso2-obam-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2carbon.pid"
    }
    'obbi_dashboard': {
      $pack               = "wso2-obbi-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/dashboard.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2/dashboard/runtime.pid"
    }
    'obbi_worker': {
      $pack               = "wso2-obbi-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/worker.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2/worker/runtime.pid"
    }
  }

  # OB solution pack locations
  $carbon_home    = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # Hostname changes in deployment.toml, conf.json params and velocity_template.xml params
  $iam_hostname       = 'CF_OBIAM_HOSTNAME'
  $analytics_hostname = 'localhost'
  $apim_hostname      = 'CF_OBAM_HOSTNAME'
  $bps_hostname       = 'localhost'

  # jaggeryapps/admin/site/conf/site.json,deployment.toml params
  $spec = 'CF_DEPLOYED_SPEC' #UK,Berlin or AU

  # DBMS related variables

  $db_password = 'CF_DB_PASSWORD'
  $db_managment_system = 'CF_DBMS'
  $oracle_sid = 'WSO2OBDB'

  if $db_managment_system == 'mysql' {
    $reg_db_user_name = 'CF_DB_USERNAME'
    $um_db_user_name = 'CF_DB_USERNAME'
    $am_db_user_name = 'CF_DB_USERNAME'
    $am_stat_db_user_name = 'CF_DB_USERNAME'
    $am_config_db_user_name = 'CF_DB_USERNAME'
    $iam_config_db_user_name = 'CF_DB_USERNAME'
    $ob_db_user_name = 'CF_DB_USERNAME'

    $wso2_reg_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_govdb?autoReconnect=true&amp;useSSL=false'
    $wso2_um_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_userdb?autoReconnect=true&amp;useSSL=false'
    $wso2_am_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_apimgtdb?autoReconnect=true&amp;useSSL=false'
    $wso2_am_config_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_am_configdb?autoReconnect=true&amp;useSSL=false'
    $wso2_iam_config_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_iskm_configdb?autoReconnect=true&amp;useSSL=false'
    $wso2_am_stat_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_apimgt_statsdb?autoReconnect=true&amp;useSSL=false'
    $wso2_ob_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_openbankingdb?autoReconnect=true&amp;useSSL=false'

    $db_driver_class_name = 'com.mysql.jdbc.Driver'
    $db_connector = 'mysql-connector-java-5.1.41-bin.jar'
    $db_validation_query = 'SELECT 1'

  } elsif $db_managment_system =~ 'oracle' {
    $reg_db_user_name = 'openbank_govdb'
    $um_db_user_name = 'openbank_userdb'
    $am_db_user_name = 'openbank_apimgtdb'
    $am_stat_db_user_name = 'openbank_apimgt_statsdb'
    $am_config_db_user_name = 'openbank_am_configdb'
    $iam_config_db_user_name = 'openbank_iskm_configdb'
    $ob_db_user_name = 'openbank_openbankingdb'

    $wso2_reg_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_um_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_am_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_am_config_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_iam_config_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_am_stat_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_ob_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"

    $db_driver_class_name = 'oracle.jdbc.OracleDriver'
    $db_validation_query = 'SELECT 1 FROM DUAL'
    $db_connector = 'ojdbc8.jar'

  } elsif $db_managment_system == 'sqlserver-se' {
    $reg_db_user_name = 'CF_DB_USERNAME'
    $um_db_user_name = 'CF_DB_USERNAME'
    $am_db_user_name = 'CF_DB_USERNAME'
    $am_stat_db_user_name = 'CF_DB_USERNAME'
    $am_config_db_user_name = 'CF_DB_USERNAME'
    $iam_config_db_user_name = 'CF_DB_USERNAME'
    $ob_db_user_name = 'CF_DB_USERNAME'

    $wso2_reg_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_govdb;SendStringParametersAsUnicode=false'
    $wso2_um_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_userdb;SendStringParametersAsUnicode=false'
    $wso2_am_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_apimgtdb;SendStringParametersAsUnicode=false'
    $wso2_am_config_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_am_configdb;SendStringParametersAsUnicode=false'
    $wso2_iam_config_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_iskm_configdb;SendStringParametersAsUnicode=false'
    $wso2_am_stat_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_apimgt_statsdb;SendStringParametersAsUnicode=false'
    $wso2_ob_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_openbankingdb;SendStringParametersAsUnicode=false'

    $db_driver_class_name = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
    $db_connector = 'mssql-jdbc-7.0.0.jre8.jar'
    $db_validation_query = 'SELECT 1'

  }

  # deployment.toml params for databases
  $db_apimgt_url                     = $wso2_am_db_url
  $db_apimgt_username                = $am_db_user_name
  $db_apimgt_password                = $db_password
  $db_apimgt_validation_query        = $db_validation_query
  $db_apimgt_driver                  = $db_driver_class_name

  $db_apimgt_stat_url                = $wso2_am_stat_db_url
  $db_apimgt_stat_username           = $am_stat_db_user_name
  $db_apimgt_stat_password           = $db_password
  $db_apimgt_stat_validation_query   = $db_validation_query
  $db_apimgt_stat_driver             = $db_driver_class_name

  $db_am_config_url                 = $wso2_am_config_db_url
  $db_am_config_username            = $am_config_db_user_name
  $db_am_config_password            = $db_password
  $db_am_config_validation_query    = $db_validation_query
  $db_am_config_driver              = $db_driver_class_name

  $db_iam_config_url                = $wso2_iam_config_db_url
  $db_iam_config_username           = $iam_config_db_user_name
  $db_iam_config_password           = $db_password
  $db_iam_config_validation_query   = $db_validation_query
  $db_iam_config_driver             = $db_driver_class_name

  $db_gov_url                       = $wso2_reg_db_url
  $db_gov_username                  = $reg_db_user_name
  $db_gov_password                  = $db_password
  $db_gov_validation_query          = $db_validation_query
  $db_gov_driver                    = $db_driver_class_name

  $db_user_store_url                = $wso2_um_db_url
  $db_user_store_username           = $um_db_user_name
  $db_user_store_password           = $db_password
  $db_user_store_validation_query   = $db_validation_query
  $db_user_store_driver             = $db_driver_class_name

  $db_open_banking_store_url                = $wso2_ob_db_url
  $db_open_banking_store_username           = $ob_db_user_name
  $db_open_banking_store_password           = $db_password
  $db_open_banking_store_validation_query   = $db_validation_query
  $db_open_banking_store_driver             = $db_driver_class_name
}

