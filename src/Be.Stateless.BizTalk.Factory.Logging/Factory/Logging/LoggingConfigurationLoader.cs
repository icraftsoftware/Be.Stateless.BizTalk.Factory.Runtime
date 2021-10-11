#region Copyright & License

// Copyright © 2012 - 2021 François Chabot
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#endregion

using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using Be.Stateless.Runtime;
using log4net;
using log4net.Config;
using EventLog = Be.Stateless.Diagnostics.EventLog;

namespace Be.Stateless.BizTalk.Factory.Logging
{
	[SuppressMessage("ReSharper", "UnusedType.Global", Justification = "Startup Service loaded at runtime.")]
	public class LoggingConfigurationLoader : IStartupService
	{
		#region IStartupService Members

		public void Execute()
		{
			var currentProcess = Process.GetCurrentProcess();

			var fileName = $"{currentProcess.MainModule!.FileName}.log4net.config";
			EventLog.WriteInformation($"{typeof(LoggingConfigurationLoader).FullName} is loading log4net XML configuration file '{fileName}'...");

			GlobalContext.Properties[BTS_HOST_NAME_PROPERTY_NAME] = Environment.GetHostName() ?? "UnrecognizedBizTalkHost";
			GlobalContext.Properties[PROCESS_ID_PROPERTY_NAME] = currentProcess.Id;

			XmlConfigurator.ConfigureAndWatch(new(fileName));
			LogManager.GetLogger(typeof(LoggingConfigurationLoader)).Info($@"log4net XML configuration file '{fileName}' has been loaded and is being watched.");
		}

		#endregion

		private const string BTS_HOST_NAME_PROPERTY_NAME = "btshost";
		private const string PROCESS_ID_PROPERTY_NAME = "pid";
	}
}
