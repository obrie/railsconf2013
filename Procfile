sensu_server:   env BUNDLE_GEMFILE=sensu/Gemfile              sensu/bin/sensu sensu-server -v
sensu_api:      env BUNDLE_GEMFILE=sensu/Gemfile              sensu/bin/sensu sensu-api -v
sensu_client:   env BUNDLE_GEMFILE=sensu/Gemfile              sensu/bin/sensu sensu-client -v
sensu_admin:    env BUNDLE_GEMFILE=Gemfile                    bash -c "cd vendor/sensu-admin && bundle exec rails server -p 4568"
batsd_receiver: env BUNDLE_GEMFILE=vendor/batsd/Gemfile       bundle exec vendor/batsd/bin/batsd -c batsd/config.yml receiver
batsd_server:   env BUNDLE_GEMFILE=vendor/batsd/Gemfile       bundle exec vendor/batsd/bin/batsd -c batsd/config.yml server
batsd_dash:     env BUNDLE_GEMFILE=batsd-dashboard/Gemfile    puma -t 0:10 -b tcp://0.0.0.0:8128 batsd-dashboard/config.ru
testapp:        env BUNDLE_GEMFILE=Gemfile                    bash -c "cd testapp && bundle exec rails server -p 3000"