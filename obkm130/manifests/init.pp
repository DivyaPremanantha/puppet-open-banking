#----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
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

class obkm130 inherits obkm130::params {

  if $jdk_version == 'ORACLE_JDK8' {
    $jdk_type = "jdk-8u144-linux-x64.tar.gz"
    $jdk_path = "jdk1.8.0_144"
  }
  elsif $jdk_version == 'OPEN_JDK8' {
    $jdk_type = "OpenJDK8U-jdk_x64_linux_hotspot_8u192b12.tar.gz"
    $jdk_path = "jdk8u192-b12"
  }

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure => present,
    uid    => $user_id,
    gid    => $user_group_id,
    home   => "/home/${user}",
    system => true,
  }

  # Ensure /opt/is directory is available
  file { "/opt/${service_name}":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  file { "/usr/lib/wso2/":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  file { "/usr/lib/wso2/wso2obkm/":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  file { "/usr/lib/wso2/wso2obkm/1.3.0/":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  # Copy the relevant installer to the /opt/is directory
  file { "/usr/lib/wso2/wso2obkm/1.3.0/${is_package}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/installers/${is_package}",
  }

  # Install WSO2 Identity Server
  exec { 'unzip':
    command => 'unzip wso2-obkm-1.3.0.zip',
    unless =>  '/usr/bin/test -d /usr/lib/wso2/wso2obkm/1.3.0/wso2-obkm-1.3.0',
    cwd     => '/usr/lib/wso2/wso2obkm/1.3.0/',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  #jdk
  file { "/usr/lib/wso2/wso2obkm/1.3.0/${jdk_type}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/installers/${jdk_type}",
  }

  # Install WSO2 Open Banking KeyManager
  exec { 'tar':
    command => "tar -xvf ${jdk_type}",
    cwd     => '/usr/lib/wso2/wso2obkm/1.3.0/',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }


  # Copy configuration changes to the installed directory
  $template_list.each |String $template| {
    file { "/usr/lib/wso2/wso2obkm/1.3.0/wso2-obkm-1.3.0/${template}":
      ensure  => file,
      owner   => $user,
      group   => $user_group,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb")
    }
  }

  # Copy wso2server.sh to installed directory
  file { "/usr/lib/wso2/wso2obkm/1.3.0/wso2-obkm-1.3.0/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
   content => template("${module_name}/carbon-home/${start_script_template}.erb")
  }

  # Copy database connector to the installed directory
  file { "/usr/lib/wso2/wso2obkm/1.3.0/wso2-obkm-1.3.0/repository/components/lib/${db_connector}":
    owner  => $user,
    group  => $user_group,
    mode   => '0754',
    source => "puppet:///modules/installers/${db_connector}",
  }

  file { "/usr/lib/wso2/wso2obkm/1.3.0/${jdk_path}/jre/lib/security/local_policy.jar":
    owner  => $user,
    group  => $user_group,
    mode   => '0754',
    ensure => present,
    source => "puppet:///modules/installers/local_policy.jar",
  }

  file { "/usr/lib/wso2/wso2obkm/1.3.0/${jdk_path}/jre/lib/security/US_export_policy.jar":
    owner  => $user,
    group  => $user_group,
    mode   => '0754',
    ensure => present,
    source => "puppet:///modules/installers/US_export_policy.jar",
  }

  #file { "/usr/local/bin/private_ip_extractor.py":
  #  owner  => $user,
  #  group  => $user_group,
  #  mode   => '0754',
  #  source => "puppet:///modules/installers/private_ip_extractor.py",
  #}

    # Copy jacoco agent to the installed directory
    file { "/usr/lib/wso2/wso2obkm/1.3.0/wso2-obkm-1.3.0/lib/jacocoagent.jar":
      owner  => $user,
      group  => $user_group,
      mode   => '0754',
      source => "puppet:///modules/installers/jacocoagent.jar",
    }

}
