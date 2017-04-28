module.exports = {
	entry: ['.', 'babel-polyfill'],
	output: {
		filename: '../public/bundle.js'
	},
	module: {
		loaders: [{
			test: /\.jsx?$/,
			loader: 'babel-loader',
			exclude: /node_modules/
		},
		{
			test: /\.styl$/,
			loader: 'style-loader!css-loader!stylus-loader'
		}]
	},
	resolve: {
		extensions: ['.js', '.jsx', '.styl']
	},
	devtool: 'source-map'
}
