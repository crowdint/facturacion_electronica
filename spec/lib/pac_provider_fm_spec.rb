require 'pac_provider_fm'

describe PacProviderFM do
  let(:xml_file) do
    xml = File.open './spec/docs_examples/base_xml_file.xml'
    xml.read
  end

  subject{ PacProviderFM.new xml_file }

  describe '#rining' do
    context 'When requesting a valid xml file' do
      specify do
        expect(subject.rining).to be_valid
      end
    end
  end
end
