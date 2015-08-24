require 'spec_helper'

describe 'Viewing todo items' do
  let!(:todo_list) { TodoList.create(title: '0Title', description: '0Description') }

  it 'displays displays title of todo list' do
    visit_todo_list(todo_list)
    within('h1') do
      expect(page).to have_content(todo_list.title)
    end
  end

  it 'displays no items when a todo list is empty' do
    visit_todo_list(todo_list)
    expect(page.all("ul.to_items li").size).to eq(0)
  end

  it 'displays item content when a todo list had items' do
    todo_list.todo_items.create(content: '0todo_list_item')
    todo_list.todo_items.create(content: '1todo_list_item')
    visit_todo_list(todo_list)

    expect(page.all('ul.todo_items li').size).to eq(2)

    within 'ul.todo_items' do
      expect(page).to have_content('0todo_list_item')
      expect(page).to have_content('1todo_list_item')
    end
  end
end
