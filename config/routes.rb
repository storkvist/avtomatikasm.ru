Rails.application.routes.draw do
  cms_fortress_routes path: '/cms-admin'

  comfy_route :cms_admin, path: '/cms-admin'

  # Make sure this routeset is defined last
  comfy_route :cms, path: '/', sitemap: true
end
