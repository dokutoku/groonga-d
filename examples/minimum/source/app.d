/**
 * minimum groonga application.
 *
 * Author: dokutoku
 * License: $(LINK2 https://creativecommons.org/publicdomain/zero/1.0/, CC0 1.0 Universal)
 */
module groonga.examples.minimum;


import groonga;

void main()

	do
	{
		grn_rc rc;

		rc = grn_init();

		if (rc != grn_rc.GRN_SUCCESS) {
			throw new Exception(`grn_init() failed.`);
		}

		scope (exit) {
			grn_fin();
		}

		//set timeout to 10 seconds
		grn_set_lock_timeout(10000);
	}
