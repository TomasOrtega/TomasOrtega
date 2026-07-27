# Development

`README.md` is the short GitHub profile. The website is built from `index.md` and `projects.md`.

## Setup

Use Ruby 4.0. `.ruby-version` pins the deployment version; local patch releases in the same series also work.

```sh
bundle config set --local path .bundle/gems
bundle install
```

## Preview

```sh
script/preview
```

Open [http://127.0.0.1:4000](http://127.0.0.1:4000). Jekyll rebuilds the website when source files change.

## Validate

```sh
script/check
```

This builds `_site` and checks the workflow, local links, image text, unused image assets, and deployment contents.

## Deploy

The workflow in `.github/workflows/pages.yml` validates pull requests and deploys pushes to `main`.

For the first deployment, open **Settings → Pages** on GitHub and change **Source** from **Deploy from a branch** to **GitHub Actions**. After that, edit the workflow file whenever the deployment process needs to change.

Keep `CNAME`; it records the custom domain in the deployed artifact.

## Repository map

- `README.md`: GitHub profile
- `index.md`: website homepage
- `projects.md`: project descriptions
- `_layouts/default.html`: shared page structure and navigation
- `_includes/project-figure.html`: shared project image markup
- `assets/css/style.scss`: website styles
- `script/preview`: local website server
- `script/check`: production build and validation
- `.github/workflows/pages.yml`: CI and deployment
