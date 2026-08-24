const CLOCK_IMAGES = import.meta.glob('../assets/*.{webp,png,jpg,jpeg,gif}', {
  eager: true,
  import: 'default',
})

const SAFE_IMAGE_NAME = /^[A-Za-z0-9._-]+$/

export function clockImageSrc(imageName) {
  if (typeof imageName !== 'string' || !SAFE_IMAGE_NAME.test(imageName)) {
    return ''
  }

  return CLOCK_IMAGES[`../assets/${imageName}`] ?? ''
}

export function safeHttpUrl(href) {
  if (typeof href !== 'string' || href.length === 0 || href.length > 2048) {
    return ''
  }

  try {
    const url = new URL(href)

    if (url.protocol !== 'https:' && url.protocol !== 'http:') {
      return ''
    }

    if (url.username || url.password) {
      return ''
    }

    return url.href
  } catch {
    return ''
  }
}
