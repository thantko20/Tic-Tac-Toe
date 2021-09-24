require_relative '../tic_tac_toe'

describe Board do
  let(:p1) { instance_double(Player, :name => 'Marco', :symbol => 'X') }
  let(:p2) { instance_double(Player, :name => 'Aaron', :symbol => 'O') }

  describe '#check_row' do
    subject(:end_game) { described_class.new(p1, p2) }
    let(:grid) { end_game.instance_variable_get(:@grid) }

    context 'when player one wins' do
      before do
        grid[0], grid[1], grid[2], grid[3] = 'X', 'X', 'X', 'O'
      end

      it 'prints Marco won!' do
        expect(end_game).to receive(:puts).with('Marco won!')
        end_game.check_row(p1)
      end

      it 'does not return true' do
        win_confirmation = end_game.check_row(p1)
        expect(win_confirmation).not_to be false
      end
    end

    context 'when player two wins' do
      before do
        grid[0], grid[1], grid[2], grid[3] = 'O', 'O', 'O', 'X'
      end

      it 'prints Aaron won!' do
        expect(end_game).to receive(:puts).with('Aaron won!')
        end_game.check_row(p2)
      end

      it 'does not return false' do
        win_confirmation = end_game.check_row(p2)
        expect(win_confirmation).not_to be false
      end
    end
  end

  describe '#draw' do
    subject(:draw_game) { described_class.new(p1, p2) }

    context 'when draws' do
      before do
        draw_game.instance_variable_set(:@turn, 9)
      end

      it 'prints Draw!' do
        expect(draw_game).to receive(:puts).with('Draw!')
        draw_game.draw?
      end

      it 'returns true' do
        draw_verification = draw_game.draw?
        expect(draw_verification).to be true
      end
    end

    context 'when does not draw' do
      before do
        draw_game.instance_variable_set(:@turn, 3)
      end

      it 'does not return true' do
        not_draw = draw_game.draw?
        expect(not_draw).not_to be true
      end
    end
  end

  describe '#player_input' do
    subject(:input_verification) { described_class.new(p1, p2) }

    context 'when user types valid input which is 2' do
      before do
        valid_input = '2'
        allow(input_verification).to receive(:gets).and_return(valid_input)
      end

      it 'stops and does not display error message' do
        error_message = "Invalid input!\n\n"
        expect(input_verification).not_to receive(:puts).with(error_message)
        input_verification.player_input
      end
    end

    context 'when user types invalid input twice and valid input later' do
      before do
        invalid_input1 = '11'
        invalid_input2 = '23'
        valid_input = '1'
        allow(input_verification).to receive(:gets).and_return(invalid_input1, invalid_input2, valid_input)
      end

      it 'displays error message twice' do
        error_message = "Invalid input!\n\n"
        expect(input_verification).to receive(:puts).with(error_message).twice
        input_verification.player_input
      end
    end
  end
  describe '#player_turn' do
    subject(:game_turn) { described_class.new(p1, p2) }

    context 'when it is @p1\'s turn' do
      it "returns player_one's name" do
        player_name = game_turn.player_turn.name
        expect(player_name).to eq('Marco')
      end
    end

    context 'when it is @p2\'s turn' do
      before do
        game_turn.instance_variable_set(:@turn, 1)
      end

      it "returns player_two's name" do
        player_name = game_turn.player_turn.name
        expect(player_name).to eq('Aaron')
      end
    end
  end
end
