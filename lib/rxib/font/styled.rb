module RXib
  module Font
    class Styled
      attr_reader :style

      FONT_STYLES = {
        'Body'     => 'UICTFontTextStyleBody',
        'Callout'  => 'UICTFontTextStyleCallout',
        'Caption1' => 'UICTFontTextStyleCaption1',
        'Caption2' => 'UICTFontTextStyleCaption2',
        'Footnote' => 'UICTFontTextStyleFootnote',
        'Headline' => 'UICTFontTextStyleHeadline',
        'Subhead'  => 'UICTFontTextStyleSubhead',
        'Title1'   => 'UICTFontTextStyleTitle1',
        'Title2'   => 'UICTFontTextStyleTitle2',
        'Title3'   => 'UICTFontTextStyleTitle3'
      }

      def initialize(components)
        @style = FONT_STYLES[components[0]]
      end
    end
  end
end
