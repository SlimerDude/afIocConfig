using afIoc

@Js
internal const class ConfigDependencyProvider : DependencyProvider {
	
	// immutable funcs not available in JS
	// @Inject	private const |->ConfigSource| 	configSource
	
	@Inject	private const Scope	scope
	
	new make(|This|in) { in(this) }

	override Bool canProvide(Scope scope, InjectionCtx ctx) {
		ctx.isFieldInjection && ctx.field.hasFacet(Config#)
	}

	override Obj? provide(Scope scope, InjectionCtx ctx) {
		conSrc		:= (ConfigSource) scope.serviceById(ConfigSource#.qname)
		config		:= (Config) ctx.field.facet(Config#)
		id 			:= config.id
		// hasDefault() doesn't exist - see http://fantom.org/forum/topic/2507
//		optional	:= config.optional ?: (ctx.field.type.isNullable || ctx.field.hasDefault)
		optional	:= config.optional ?: ctx.field.type.isNullable
		
		if (id != null)
			return conSrc.get(id, ctx.field.type, !optional)
		
		pod		:= ctx.field.parent.pod.name.decapitalize
		clazz	:= ctx.field.parent.name.decapitalize
		field	:= ctx.field.name.decapitalize
		
		qnames	:= "${field} ${pod}.${field} ${pod}.${clazz}.${field} ${clazz}.${field}".split
		name	:= qnames.find { conSrc.config.containsKey(it) }
		
		if (name == null)
			name = conSrc.config.keys.find { this.fromDisplayName(it).equalsIgnoreCase(field) }

		if (name == null)
			return optional ? null : throw ConfigNotFoundErr(ErrMsgs.couldNotDetermineId(ctx.field, qnames), conSrc.config.keys)

		value 	:= conSrc.get(name, ctx.field.type)
		return value
	}
	
	private Str fromDisplayName(Str name) {
		Str.fromChars(name.chars.findAll { it.isAlphaNum })
	}
}
