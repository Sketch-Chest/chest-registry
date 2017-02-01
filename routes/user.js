const {Router} = require('express')

const router = new Router()

/* GET users listing. */
router.get('/', (req, res) => {
  res.send('respond with a resource')
})

router.post('/', (req, res) => {
  res.json({})
})

module.exports = router
