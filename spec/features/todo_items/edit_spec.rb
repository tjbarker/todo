require 'spec_helper'

describe 'Editing todo items' do
  let!(:todo_list) { TodoList.create(title: '0Title', description: '0Description') }
  let!(:todo_item) { todo_list.todo_items.create(content: "This is content") }

  it 'is successful with valid content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link 'Edit'
    end
    fill_in 'Content', with: 'This is edited content'
    click_button 'Save'
    expect(page).to have_content('Saved todo list items.')
    todo_item.reload
    expect(todo_item.content).to eq('This is edited content')
  end

  it 'is unsuccessful with no content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link 'Edit'
    end
    fill_in 'Content', with: ''
    click_button 'Save'
    expect(page).to have_content("That todo item could not be saved")
    todo_item.reload
    expect(todo_item.content).to eq('This is content')
  end

  it 'is unsuccessful with not enough content content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link 'Edit'
    end
    fill_in 'Content', with: '12'
    click_button 'Save'
    expect(page).to have_content("That todo item could not be saved")
    todo_item.reload
    expect(todo_item.content).to eq('This is content')
  end
end
