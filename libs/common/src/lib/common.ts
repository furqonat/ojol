export function str2obj(input?: unknown) {
  if (!input) {
    return undefined
  }
  if (Object.keys(input).length === 0) {
    return undefined
  }
  return input
    ? JSON.parse(JSON.stringify(input), (key, value) => {
        if (value === 'true' || value === 'false') {
          return value == 'true'
        } else if (
          typeof value === 'string' &&
          key !== '' &&
          value.startsWith('{')
        ) {
          return eval('(' + value + ')')
        } else {
          return value
        }
      })
    : undefined
}
