require 'spec_helper'

describe 'Editing todo lists' do
  let!(:todo_list) { todo_list = TodoList.create(title: '0Title', description: '0Description') }

  def update_todo_list(options={})
    options[:title] ||= 'Title_Edited'
    options[:description] ||='Description_Edited'
    todo_list = options[:todo_list] ||= todo_list

    visit '/todo_lists'

    within "#todo_list_#{todo_list.id}" do
      click_link 'Edit'
    end

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button 'Update Todo list'

    todo_list.reload
  end

  it 'updates a todo list successfully with correct information' do
    update_todo_list todo_list: todo_list

    expect(page).to have_content('Todo list updated')
    expect(todo_list.title).to eq('Title_Edited')
    expect(todo_list.description).to eq('Description_Edited')
  end

  it 'displays error with no title' do
    update_todo_list todo_list: todo_list, title: ''
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content('error')
  end

  it 'displays error with too short a title' do
    update_todo_list todo_list: todo_list, title: '12'
    expect(page).to have_content('error')
  end

  it 'displays error with no description' do
    update_todo_list todo_list: todo_list, description: ''
    expect(page).to have_content('error')
  end

  it 'displays error with too short a description' do
    update_todo_list todo_list: todo_list, description: '1234'
    expect(page).to have_content('error')
  end
end
