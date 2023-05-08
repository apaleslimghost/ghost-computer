const { withEsbuildOverride } = require('remix-esbuild-override')
const civetPlugin = require('@danielx/civet/esbuild-plugin')
const {
	routeModuleExts,
} = require('@remix-run/dev/dist/config/routesConvention')

routeModuleExts.push('.civet')

withEsbuildOverride((options) => {
	options.plugins = [civetPlugin(), ...options.plugins]
	return options
})

/** @type {import('@remix-run/dev').AppConfig} */
module.exports = {
	ignoredRouteFiles: ['**/.*'],
}
