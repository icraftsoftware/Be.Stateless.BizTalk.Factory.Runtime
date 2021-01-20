param(
   [Parameter(Mandatory = $true)]
   [ValidateSet('DEV', 'BLD', 'ACC', 'PRE', 'PRD')]
   $TargetEnvironment
)

LibraryManifest -Name BizTalk.Factory.Runtime -Description 'Comprehensive BizTalk Server Runtime' -Build {
   Assembly -Path (Get-ResourceItem -Name log4net,
      Be.Stateless.Common,
      Be.Stateless.Extensions,
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
}