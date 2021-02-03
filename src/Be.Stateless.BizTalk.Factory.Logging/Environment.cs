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

using System;
using System.Diagnostics.CodeAnalysis;
using Be.Stateless.Diagnostics;

namespace Be.Stateless.BizTalk
{
	public static class Environment
	{
		[SuppressMessage("ReSharper", "CommentTypo")]
		public static string GetHostName()
		{
			// e.g. "C:\Program Files (x86)\Microsoft BizTalk Server\BTSNTSvc64.exe" -group "BizTalk Group" -name "BizTalkServerApplication" -btsapp "{EA0E4664-2493-40C7-B7C9-CD33C671F0D5}"
			var args = System.Environment.GetCommandLineArgs();
			var index = Array.IndexOf(args, "-name", 1);
			if (index > 0) return args[index + 1];

			EventLog.WriteWarning($"Failed to parse BizTalk Server Host Name from command line: {System.Environment.CommandLine}.");
			return null;
		}
	}
}
