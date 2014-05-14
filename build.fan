using build

class Build : BuildPod {

	new make() {
		podName = "afIocConfig"
		summary = "An IoC library for providing injectable config values"
		version = Version("1.0.7")

		meta = [
			"proj.name"		: "IoC Config",
			"afIoc.module"	: "afIocConfig::IocConfigModule",
			"tags"			: "system",
			"repo.private"	: "true",
		]

		index = [	
			"afIoc.module"	: "afIocConfig::IocConfigModule"
		]

		depends = [
			"sys 1.0", 
			
			"afIoc 1.6.0+"
		]

		srcDirs = [`test/unit-tests/`, `fan/`, `fan/public/`, `fan/internal/`]
		resDirs = [,]

		docApi = true
		docSrc = true
	}
}
