require 'pry'
require 'pp'
require_relative 'lib/spacex_api'
require_relative 'lib/launch'
require_relative 'presenters/launches_by_month'


costs = SpacexApi.new.rockets.map { |rocket| [rocket['name'], rocket['cost_per_launch']] }
launches = SpacexApi.new.launches.map { |launch| Launch.parse(launch, costs.to_h) }

Presenters::LaunchesByMonth.new(launches).print
# Presenters::TotalPayload.new(launches).print
# Presenters::CostsByRocket.new(launches).print
# Presenters::CostsByYear.new(launches).print


