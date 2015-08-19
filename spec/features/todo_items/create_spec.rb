require 'spec_helper'

describe 'Adding todo items' do
  let!(:todo_list) { TodoList.create(title: '0Title', description: '0Description') }

  def visit_todo_list(list)
    visit '/todo_lists'
    within "#todo_list_#{list.id}" do
      click_link 'List Items'
    end
  end

  it 'is successful with valid content' do
    visit_todo_list(todo_list)
    click_link 'New Todo Item'
    fill_in 'Content', with: 'This is content'
    click_button 'Save'
    expect(page).to have_content('Added todo list item.')
    within('ul.todo_items') do
      expect(page).to have_content('This is content')
    end
  end
end
