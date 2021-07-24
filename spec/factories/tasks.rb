FactoryBot.define do
  factory :task do
    url { "https://atcoder.jp/example/test/data/sample_url/" }
    status { 0 }   
  end

  factory :task_seq do
    url { "https://atcoder.jp/example/test/data/sample_url/" }
    status { 0 }
  end
end
