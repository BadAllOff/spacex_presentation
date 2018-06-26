require 'pry'
require 'pp'
require_relative 'lib/spacex_api'
require_relative 'lib/launch'
require_relative 'presenters/basePresenter'
require_relative 'presenters/launches_by_month'
require_relative 'presenters/total_payload'


costs = SpacexApi.new.rockets.map { |rocket| [rocket['name'], rocket['cost_per_launch']] }
launches = SpacexApi.new.launches.map { |launch| Launch.parse(launch, costs.to_h) }

puts costs

Presenters::LaunchesByMonth.new(launches).print
Presenters::TotalPayload.new(launches, 0).print
Presenters::CostsByRocket.new(launches).print
# Presenters::CostsByYear.new(launches).print


