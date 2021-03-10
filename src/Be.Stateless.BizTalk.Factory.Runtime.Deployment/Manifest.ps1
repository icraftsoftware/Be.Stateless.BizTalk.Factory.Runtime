#region Copyright & License

# Copyright © 2019 - 2021 François Chabot
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

[CmdletBinding()]
[OutputType([hashtable])]
param()

Set-StrictMode -Version Latest

LibraryManifest -Name BizTalk.Factory.Runtime -Description 'BizTalk.Factory''s Comprehensive Set of BizTalk Server Runtime Components.' -Build {
   Assembly -Path (Get-ResourceItem -Name log4net,
      Be.Stateless.Extensions,
      Be.Stateless.Reflection,
      Be.Stateless.Security,
      Be.Stateless.Stream,
      Be.Stateless.Xml,
      Be.Stateless.BizTalk.Abstractions,
      Be.Stateless.BizTalk.Activity.Tracking,
      Be.Stateless.BizTalk.Messaging,
      Be.Stateless.BizTalk.Pipeline.MicroComponents,
      Be.Stateless.BizTalk.ServiceModel,
      Be.Stateless.BizTalk.Settings,
      Be.Stateless.BizTalk.Stream,
      Be.Stateless.BizTalk.Transform.ExtensionObjects,
      Be.Stateless.BizTalk.XLang,
      Be.Stateless.BizTalk.Xml
   )
   XmlConfiguration -Path (Get-ResourceItem -Name machine -Extension .config)
}