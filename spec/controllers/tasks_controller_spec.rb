require "rails_helper"

RSpec.describe TasksController, :type => :controller do

  describe "Tasks API" do
    it 'gets tasks' do
      Task.create! text: 'yada yada yada'
      Task.create! text: 'yada yada yada 2'

      get :index

      json = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      # check to make sure the right amount of tasks are returned
      expect(json.length).to eq(2)
    end
  end

  it 'gets task' do
    t= Task.create! text: 'yada yada yada'

    get :show, id: t.id

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right task is returned
    expect(json['id']).to eq(t.id)
  end

  it 'destroys task' do
    t= Task.create! text: 'yada yada yada'

    get :show, id: t.id

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the task was created
    expect(json['id']).to eq(t.id)

    delete :destroy, format: :json, id: t.id

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure no tasks are present
    get :index

    # test for the 200 status-code
    expect(response).to be_success

    json = JSON.parse(response.body)

    # check to make sure the no amount of tasks are returned
    expect(json.length).to eq(0)
  end

  it 'creates task' do
    post :create, :task => {title: "yada"}

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the task was created
    expect(json['id']).to eq(Task.last.id)
  end

  it 'updates task' do
    t= Task.create! text: 'yada yada yada'

    put :update, id: t.id, task: {completed: true}

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the task is now completed
    expect(json['completed']).to eq(true)
  end

end
