const {Router} = require('express');

const router = new Router();

/* GET home page. */

router.get('/', (req, res) => {
	res.json({index: true});
});

module.exports = router;
