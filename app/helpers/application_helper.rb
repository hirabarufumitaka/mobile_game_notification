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
      title: 'ソシャゲイベントをまとめて簡単に検索',
      reverse: true,
      separator: '|',
      description: 'ソシャゲイベント情報は複数のソシャゲのイベントをまとめて簡単に探すことができるサイトです。',
      keywords: 'ソシャゲ, イベント, プロセカ',
      canonical: request.original_url,
      icon: [
        { href: image_url('logo.png'), sizes: '32x32' },
        { href: image_url('logo.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: 'ソシャゲイベント情報',
        title: 'ソシャゲイベントをまとめて簡単に検索',
        description: 'ソシャゲイベント情報は複数のソシャゲのイベントをまとめて簡単に探すことができるサイトです。',
        type: 'website',
        url: request.original_url,
        image: image_url('logo.png')
      },
      twitter: {
        card: 'summary_large_image',
        site: '@barusrun',
        title: 'ソシャゲイベントをまとめて簡単に検索',
        image: image_url('logo.png')
      }
    }
  end
end
