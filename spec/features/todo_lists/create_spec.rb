require 'spec_helper'

describe 'Creating todo lists' do
  it 'redirects to the todo list index page on success' do
    visit '/todo_lists'
    click_link 'New Todo list'

    expect(page).to have_content('New Todo List')

    fill_in 'Title', with: 'this is the title'
    fill_in 'Description', with: 'this is the desciption'
    click_button 'Create Todo list'

    expect(page).to have_content('this is the title')
  end

  it 'displays error when todo list has no title' do

    visit '/todo_lists'
    click_link 'New Todo list'

    expect(page).to have_content('New Todo List')

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'this is the desciption'
    click_button 'Create Todo list'

    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the title')
  end

  it 'displays error when todo list title has less than 3 characters' do

    visit '/todo_lists'
    click_link 'New Todo list'

    expect(page).to have_content('New Todo List')

    fill_in 'Title', with: '12'
    fill_in 'Description', with: 'this is the desciption'
    click_button 'Create Todo list'

    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the title')
  end

  it 'displays error when todo list has no description' do

    visit '/todo_lists'
    click_link 'New Todo list'

    expect(page).to have_content('New Todo List')

    fill_in 'Title', with: 'this is the title'
    fill_in 'Description', with: ''
    click_button 'Create Todo list'

    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the description')
  end

  it 'displays error when todo list description has less than 5 characters' do

    visit '/todo_lists'
    click_link 'New Todo list'

    expect(page).to have_content('New Todo List')

    fill_in 'Title', with: 'this is the title'
    fill_in 'Description', with: '1234'
    click_button 'Create Todo list'

    expect(TodoList.count).to eq(0)
    expect(page).to have_content('error')

    visit '/todo_lists'
    expect(page).to_not have_content('this is the title')
  end
end
