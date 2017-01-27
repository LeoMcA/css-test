import { htmlHelper } from 'discourse-common/lib/helpers'

export default htmlHelper(string => {
  return string.substring(0, 50) + '...'
})
