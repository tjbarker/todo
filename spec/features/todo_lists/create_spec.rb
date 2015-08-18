require 'spec_helper'

describe 'Creating todo lists' do
  def create_todo_list(options={})
    options[:title] ||= 'this is the title'
    options[:description] ||='this is the description'

    visit '/todo_lists'
    click_link 'New Todo list'

    expect(page).to have_content('New Todo List')

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button 'Create Todo list'
  end

  it 'redirects to the todo list index page on success' do
    create_todo_list
    expect(page).to have_content('this is the title')
  end

  it 'displays error when todo list has no title' do
    create_todo_list title:''
    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the title')
  end

  it 'displays error when todo list title has less than 3 characters' do
    create_todo_list title: '12'
    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the title')
  end

  it 'displays error when todo list has no description' do
    create_todo_list description: ''

    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the description')
  end

  it 'displays error when todo list description has less than 5 characters' do
    create_todo_list description:'1234'
    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the title')
  end
end
