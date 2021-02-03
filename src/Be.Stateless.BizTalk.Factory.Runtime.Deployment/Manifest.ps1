#region Copyright & License

# Copyright © 2019 - 2022 François Chabot
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#endregion

#Requires -Modules @{ ModuleName = 'BizTalk.Deployment' ; ModuleVersion = '2.1.0.0' ; MaximumVersion = '2.2.0.0' ; GUID = '533b5f59-49ce-4f51-a293-cb78f5cf81b5' }

[CmdletBinding()]
[OutputType([HashTable])]
param(
   [Parameter(Mandatory = $false)]
   [ValidateNotNullOrEmpty()]
   [ValidateScript( { Test-Path -Path $_ } )]
   [string]
   $LogDirectory = 'C:\Files\Logs',

   [Parameter(Mandatory = $false)]
   [ValidateSet('ALL', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL', 'OFF')]
   [string]
   $LogLevel = 'DEBUG'
)

Set-StrictMode -Version Latest

LibraryManifest -Name BizTalk.Factory.Runtime -Description 'BizTalk.Factory''s Comprehensive Set of BizTalk Server Runtime Components.' -Build {
   Assembly -Path (Get-ResourceItem -Name log4net) -InstallReference BizTalk.Factory.Runtime
   Assembly -Path (Get-ResourceItem -Name Be.Stateless.Extensions,
      Be.Stateless.Reflection,
      Be.Stateless.Runtime,
      Be.Stateless.Security,
      Be.Stateless.Stream,
      Be.Stateless.Xml,
      Be.Stateless.BizTalk.Abstractions,
      Be.Stateless.BizTalk.Factory.Logging,
      Be.Stateless.BizTalk.Messaging,
      Be.Stateless.BizTalk.Pipeline.MicroComponents,
      Be.Stateless.BizTalk.ServiceModel,
      Be.Stateless.BizTalk.Settings,
      Be.Stateless.BizTalk.Stream,
      Be.Stateless.BizTalk.Transform.ExtensionObjects,
      Be.Stateless.BizTalk.XLang,
      Be.Stateless.BizTalk.Xml
   )
   EventLogSource -Name 'BizTalk.Factory' -LogName Application
   File -Path (Get-ResourceItem -Name BTSNTSvc.exe.log4net -Extension .config) `
      -Destination (Join-Path $env:BTSINSTALLPATH BTSNTSvc.exe.log4net.config), (Join-Path $env:BTSINSTALLPATH BTSNTSvc64.exe.log4net.config)
   XmlConfigurationAction -Path (Join-Path $env:BTSINSTALLPATH BTSNTSvc.exe.log4net.config) `
      -Update /log4net/appender[@name="'RollingFileAppender'"]/file `
      -Attribute @{ value = $(Join-Path $LogDirectory '%property{btshost}.log') }
   XmlConfigurationAction -Path (Join-Path $env:BTSINSTALLPATH BTSNTSvc64.exe.log4net.config) `
      -Update /log4net/appender[@name="'RollingFileAppender'"]/file `
      -Attribute @{ value = $(Join-Path $LogDirectory '%property{btshost}.log') }
   XmlConfigurationAction -Path (Join-Path $env:BTSINSTALLPATH BTSNTSvc.exe.log4net.config) `
      -Update /log4net/root/level `
      -Attribute @{ value = $LogLevel }
   XmlConfigurationAction -Path (Join-Path $env:BTSINSTALLPATH BTSNTSvc64.exe.log4net.config) `
      -Update /log4net/root/level `
      -Attribute @{ value = $LogLevel }
   XmlConfiguration -Path (Get-ResourceItem -Name BTSNTSvc.exe, machine -Extension .config)
}