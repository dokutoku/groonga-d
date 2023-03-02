/**
 * minimum groonga application.
 *
 * Author: dokutoku
 * License: CC0 Universal
 */
module groonga.examples.minimum;


import groonga;

void main()

	do
	{
		grn_rc rc;

		rc = grn_init();

		if (rc != grn_rc.GRN_SUCCESS) {
			throw new Exception(`initialization failed.`);
		}

		scope (exit) {
			grn_fin();
		}

		//set timeout to 10 seconds
		grn_set_lock_timeout(10000);
	}
