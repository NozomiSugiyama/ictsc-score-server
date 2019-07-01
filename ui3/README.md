# ictsc-score-server UI

## Getting Started

## Development
### Generate GraphQL Code
```bash
$ yarn graphql-code-generate
```
#### Editor setup
https://github.com/styled-components/vscode-styled-components

## file size analyze
### cmd
```bash
$ yarn size-analyze
```

### web-view
uncomment `// new BundleAnalyzerPlugin()` in `webpack.config.(dev|prod).js`
```js
...
    plugins: [
        new BundleAnalyzerPlugin(), // <- uncomment
        new DefinePlugin(
            Object.entries(process.env)
                .map(x => ({["process.env." + x[0]]: JSON.stringify(x[1])}))
                .reduce((x, y) => Object.assign(x, y), {}),
        )
    ],
...
```

## Generate Documents
```bash
$ yarn docs
```
