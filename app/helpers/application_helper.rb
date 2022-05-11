module ApplicationHelper
  def page_title(page_title = '', admin: false)
    base_title = if admin
                   'mobile game notification(管理画面)'
                 else
                   'mobile game notification'
                 end
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  def default_meta_tags
    {
      site: 'ソシャゲイベント情報',
      title: 'ソシャゲイベントをもう忘れない！',
      reverse: true,
      separator: '|',
      description: 'ソシャゲのイベントをまとめて検索・通知することが出来ます。',
      keywords: 'ソシャゲ, イベント, プロセカ',
      canonical: request.original_url,
      icon: [
        { href: image_url('logo.png'), sizes: '32x32' },
        { href: image_url('logo.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: 'ソシャゲイベント情報',
        title: 'ソシャゲイベントをもう忘れない！',
        description: 'ソシャゲのイベントをまとめて検索・通知することが出来ます。',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.jpg')
      },
      twitter: {
        card: 'summary_large_image',
        site: '@socialgameevent'
      }
    }
  end
end
