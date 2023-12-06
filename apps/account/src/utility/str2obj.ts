export function str2obj(input?: unknown) {
  if (!input) {
    return undefined
  }
  if (Object.keys(input).length === 0) {
    return undefined
  }
  return input
    ? JSON.parse(JSON.stringify(input), (key, value) =>
        value === 'true' || value === 'false' ? value === 'true' : value,
      )
    : undefined
}
