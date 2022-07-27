require '../lib/gameplay.rb'
require '../lib/castling.rb'

describe Castling do
  describe '#castle' do
    context 'When conditions are successfully met to allow castling' do
      it 'Moves the king two squares over' do
        
      end

      it 'Moves the rook to the square the king stepped over' do
        
      end
    end
  end

  describe '#squares_empty?' do
    context 'When all squares between the rook and king are empty' do
      it 'Returns true' do
        
      end
    end

    context 'When a square between rook and king is occupied' do
      it 'Returns false' do
        
      end
    end
  end

  describe '#castlable?' do
    context 'When king is in check' do
      it 'Returns false' do
        
      end
    end

    context 'When the king must move over a square that is attacked by an enemy piece during the castle move' do
      it 'Returns false' do
        
      end
    end


    context 'When the king tries to move to a square that is attacked by an enemy piece/leaves the king in check' do
      it 'Returns false' do
        
      end
    end

    context 'When all conditions are met to allow king to perform castling' do
      it 'Returns true' do
        
      end
    end
  end
end