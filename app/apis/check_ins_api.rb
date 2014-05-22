class CheckInsApi < Grape::API
  desc 'Get a list of check_ins'
  params do
    optional :ids, type: String, desc: 'comma separated check_in ids'
  end
  get do
    check_ins = CheckIn.filter(declared(params, include_missing: false))
    represent check_ins, with: CheckInRepresenter
  end

  desc 'Create a check_in'
  params do
    optional :user, type: String, desc: 'id of the user checking in'
    optional :business, type: String, desc: 'id of the business checked into'
  end

  post do
    check_in = CheckIn.create(declared(params, include_missing: false))
    error!(present_error(:record_invalid, check_in.errors.full_messages)) unless check_in.errors.empty?
    represent check_in, with: CheckInRepresenter
  end

  params do
    requires :id, desc: 'ID of the check_in'
  end
  route_param :id do
    desc 'Get an check_in'
    get do
      check_in = CheckIn.find(params[:id])
      represent check_in, with: CheckInRepresenter
    end

    desc 'Update an check_in'
    params do
      optional :user, type: String, desc: 'id of the user checking in'
      optional :business, type: String, desc: 'id of the business checked into'
    end
    put do
      # fetch check_in record and update attributes.  exceptions caught in app.rb
      check_in = CheckIn.find(params[:id])
      check_in.update_attributes!(declared(params, include_missing: false))
      represent check_in, with: CheckInRepresenter
    end
  end
end
