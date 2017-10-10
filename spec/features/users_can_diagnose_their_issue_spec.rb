require 'rails_helper'

RSpec.feature 'Users can diagnose their issue' do
  scenario 'viewing a multiple-choice question' do
    allow_any_instance_of(QuestionSet)
      .to receive(:questions)
      .and_return(
        'first' => {
          'question' => 'Is there a danger of flooding?',
          'answers' => [
            { 'text' => 'Yeah' },
            { 'text' => 'Nope' },
          ],
        }
      )
    visit '/questions/first'

    expect(page).to have_content 'Is there a danger of flooding?'

    expect(page).to have_unchecked_field 'Yeah'
    expect(page).to have_unchecked_field 'Nope'
  end

  scenario 'viewing a question which requires text input' do
    allow_any_instance_of(QuestionSet)
      .to receive(:questions)
      .and_return(
        'first' => {
          'question' => 'Please describe your first pet',
        }
      )
    visit '/questions/first'

    expect(page).to have_content 'Please describe your first pet'
    expect(page).to have_field 'form_answer', type: 'textarea'
  end

  scenario 'choosing an answer that moves on to another question' do
    allow_any_instance_of(QuestionSet)
      .to receive(:questions)
      .and_return(
        'first' => {
          'question' => 'Are you having fun yet?',
          'answers' => [
            {
              'text' => 'Yes',
              'goto' => 'second',
            },
            {
              'text' => 'No',
            },
          ],
        },
        'second' => {
          'question' => 'Are you sure?',
          'answers' => [
            { 'text' => 'Absolutely!' },
          ],
        }
      )

    visit '/questions/first'
    choose_radio_button 'Yes'
    click_on 'Continue'

    expect(page.current_path).to eql '/questions/second'
    expect(page).to have_content 'Are you sure?'
    expect(page).to have_unchecked_field 'Absolutely!'
  end

  scenario 'choosing an answer that requires the user to see some static content' do
    allow_any_instance_of(QuestionSet)
      .to receive(:questions)
      .and_return(
        'flood' => {
          'question' => 'Is there a danger of flooding?',
          'answers' => [
            {
              'text' => 'Yes',
              'page' => 'emergency_contact',
            },
          ],
        }
      )

    visit '/questions/flood'
    choose_radio_button 'Yes'
    click_on 'Continue'

    expect(page.current_path).to eql '/pages/emergency_contact'
    expect(page).to have_content 'Please call our repair centre'
  end

  scenario 'choosing an answer redirects to the address search page by default' do
    allow_any_instance_of(QuestionSet)
      .to receive(:questions)
      .and_return(
        'where' => {
          'question' => 'Where does this question go?',
          'answers' => [
            { 'text' => 'Nowhere' },
          ],
        }
      )

    visit '/questions/where'
    choose_radio_button 'Nowhere'
    click_on 'Continue'

    expect(page).to have_content 'What is your address?'
  end
end
